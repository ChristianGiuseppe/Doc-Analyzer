
import os
import random
import numpy as np
from PIL import Image
import pandas as pd
import torch
import torch.nn as nn
import torch.utils.data as D
import torch.nn.functional as F
from torchvision import transforms, models
from sklearn.model_selection import train_test_split
from sklearn.model_selection import KFold, StratifiedKFold
from tqdm import tqdm
import itertools
from sklearn.metrics import confusion_matrix, classification_report, multilabel_confusion_matrix
from sklearn.tree import DecisionTreeClassifier
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import roc_curve, roc_auc_score

import matplotlib.pyplot as plt

import copy 

import timm
from pytorch_grad_cam import GradCAM, HiResCAM, ScoreCAM, GradCAMPlusPlus, AblationCAM, XGradCAM, EigenCAM, FullGrad
from pytorch_grad_cam.utils.model_targets import ClassifierOutputTarget
from pytorch_grad_cam.utils.image import show_cam_on_image,\
    preprocess_image

import cv2


import base64
import io


def evaluate():

    device = torch.device("cpu")




    def reshape_transform(tensor, height=14, width=14):
        result = tensor[:, 1:, :].reshape(tensor.size(0),
                                          height, width, tensor.size(2))

        # Bring the channels to the first dimension,
        # like in CNNs.
        result = result.transpose(2, 3).transpose(1, 2)
        print(result.shape)
        return result
    imgGRAD = '_input.tif'
    batchSize = 1#14 ##96 with mobilenet
    loader_opts = {'batch_size': batchSize, 'num_workers': 0, 'pin_memory': False}

    model = torch.hub.load('facebookresearch/deit:main', 'deit_tiny_patch16_224', pretrained=True)# prima era deit_base_patch16_224


    loaded_weights = torch.load('./best_model.pth',map_location='cpu',)


    model.eval()
    model.load_state_dict(loaded_weights, strict=False)
    model.blocks[-1].norm1.requires_grad = True
    target_layers = [model.blocks[-1].norm1]
    cam = GradCAM(model=model, target_layers=target_layers, use_cuda=False, reshape_transform = reshape_transform)
    #targets = [ClassifierOutputTarget(1)]
    targets = None
    #test_loader = D.DataLoader(ds_test, batch_size=1, shuffle=False, num_workers=1)

    rgb_img = cv2.imread(imgGRAD, 1)[:, :, ::-1]
    rgb_img = cv2.resize(rgb_img, (224, 224))
    rgb_img = np.float32(rgb_img) / 255
    #rgb_img = np.transpose(rgb_img, (2, 0, 1))
    rgb_img = torch.from_numpy(rgb_img)
    #rgb_img = rgb_img.transpose(1, 2).transpose(0, 1)
    print(rgb_img.cpu().numpy().shape)
    #print(rgb_img.shape)
    input_tensor = preprocess_image(rgb_img.cpu().numpy(), mean=[0.5, 0.5, 0.5],
                                        std=[0.5, 0.5, 0.5])
    #print(input_tensor.shape)


    grayscale_cam = cam(input_tensor=input_tensor)
    grayscale_cam = grayscale_cam[0, :]

    #rgb_show = np.transpose(rgb_img, (2, 0, 1))
    visualization = show_cam_on_image(rgb_img.cpu().numpy(), grayscale_cam, use_rgb=True)

    cam_image = cv2.cvtColor(visualization, cv2.COLOR_RGB2BGR)
    cv2.imwrite("_cam.jpg", cam_image)
    return "pic_hash"