<p align="center">
  <img src="assets/images/portfolio-banner.png" alt="Biomedical Data Analytics Portfolio Banner" width="100%">
</p>

<br>

# EEG-Based Motor Intent Classification for Lower-Limb Movements

---

## Quick Facts

| Attribute | Details |
|-----------|----------|
| **Project Type** | Academic Research Project |
| **Field** | Biomedical Engineering |
| **Domain** | Brain–Computer Interfaces (BCIs) |
| **Institution** | Tecnológico de Monterrey |
| **Course** | Design and Development in Neuroengineering |
| **Programming Language** | MATLAB |
| **Libraries** | FieldTrip Toolbox |
| **Data Type** | Electroencephalography (EEG) |
| **Dataset** | Experimental EEG recordings from a healthy volunteer *(not publicly available for privacy reasons)* |
| **Machine Learning Models** | Linear Discriminant Analysis (LDA), Decision Trees |
| **Validation Strategy** | 5-Fold Cross Validation |
| **Repository Status** | Under Active Documentation |

---

# Executive Summary

This repository presents an end-to-end biomedical data analytics workflow for decoding lower-limb motor activity from electroencephalographic (EEG) signals.

The project integrates experimental data acquisition, signal preprocessing, feature engineering, machine learning, and neurophysiological interpretation to evaluate whether EEG signals can reliably classify lower-limb motor activity.

Rather than focusing exclusively on model performance, this repository documents the complete analytical pipeline required to transform raw biomedical signals into meaningful information.

---

# Why This Project Matters

Brain–Computer Interfaces (BCIs) are emerging technologies capable of translating neural activity into commands for external systems. Their applications include neurorehabilitation, assistive technologies, prosthetic control, and communication systems for patients with neurological disorders.

Reliable decoding of lower-limb motor intentions remains challenging because EEG signals exhibit low signal-to-noise ratios, inter-subject variability, and non-stationary behavior.

This project explores how signal processing and machine learning techniques can be combined to classify voluntary lower-limb motor activity using EEG recordings.

---

# Research Question

> Can EEG signals recorded over sensorimotor regions reliably classify lower-limb motor activity and distinguish movement laterality using machine learning techniques?

---

# Objectives

This project aims to:

- Develop an EEG processing pipeline for lower-limb motor activity.
- Improve EEG signal quality through preprocessing.
- Extract meaningful neurophysiological features.
- Train and evaluate machine learning classifiers.
- Compare classification performance across multiple motor tasks.

---

<p align="center">
  <img src="assets/images/experimental-workflow2.png"
       alt="Experimental Workflow"
       width="100%">
</p>

<p align="center">
<i>Figure 1. End-to-end analytical workflow from EEG acquisition to clinical interpretation.</i>
</p>

---

# Experimental Design

The study consisted of **two EEG acquisition sessions**, separated by **one week**, to evaluate the reproducibility of lower-limb motor activity recordings over time.

During each session, the participant completed a structured experimental protocol including alternating periods of:

- Rest
- Right-leg movement
- Right-leg motor imagery
- Left-leg movement
- Left-leg motor imagery

Each task followed a predefined timing sequence, enabling automatic segmentation and labeling of EEG epochs during the data processing stage.

All EEG recordings were acquired using an eight-channel BioSemi system and later processed in MATLAB using the FieldTrip toolbox.

---

## Experimental Protocol

<p align="center">
  <img src="assets/images/experimental-protocol.png"
       alt="Experimental Protocol"
       width="95%">
</p>

<p align="center">
<i><b>Figure 2.</b> Experimental protocol consisting of two EEG acquisition sessions separated by one week. During each session, the participant completed alternating periods of rest, lower-limb movement, and motor imagery following a standardized timing sequence.</i>
</p>

---

# Data Acquisition

EEG recordings were acquired using the following channels:

- Fz
- C3
- Cz
- C4
- Pz
- PO7
- Oz
- PO8

Raw signals were stored in BioSemi BDF format and processed using the FieldTrip MATLAB toolbox.

---

# Signal Processing Pipeline

The complete preprocessing workflow transformed raw EEG recordings into a structured feature matrix suitable for machine learning. Each stage was implemented in MATLAB using the FieldTrip toolbox to ensure reproducibility and consistent processing across both acquisition sessions.

<p align="center">
  <img src="assets/images/signal-processing-pipeline.png"
       alt="Signal Processing Pipeline"
       width="100%">
</p>

<p align="center">
<i><b>Figure 3.</b> End-to-end preprocessing pipeline applied to the raw EEG recordings, including filtering, common average referencing, epoch segmentation, spectral analysis, and feature extraction prior to machine learning.</i>
</p>

---

# Preprocessing

The preprocessing pipeline included:

- Removal of the initial recording segment.
- High-pass FIR filter (5 Hz).
- Low-pass FIR filter (35 Hz).
- Notch FIR filter (59–61 Hz).
- Common Average Reference (CAR).
- Segmentation into 480 epochs of 5 seconds each.

---

# Feature Engineering

Features were extracted from frequency-domain representations of EEG signals.

Frequency bands included:

- Mu (8–13 Hz)
- Low Beta (13–20 Hz)
- High Beta (20–30 Hz)
- Motor Band (8–30 Hz)

Additional engineered features included:

- C3–C4 asymmetry
- Cz versus lateral motor cortex activity

These features were used as predictors for machine learning models.

---

# Machine Learning Workflow

The extracted EEG features were organized into a structured dataset and used to train multiple supervised classification models. Decision Trees and Linear Discriminant Analysis (LDA) were evaluated using a 5-fold cross-validation strategy to compare their ability to classify lower-limb motor activity.

<p align="center">
  <img src="assets/images/machine-learning-workflow.png"
       alt="Machine Learning Workflow"
       width="100%">
</p>

<p align="center">
<i><b>Figure 4.</b> Machine learning workflow from feature matrix construction to model comparison and performance evaluation using cross-validation.</i>
</p>


---

# Performance Evaluation

Model performance was evaluated using:

- Accuracy
- Sensitivity
- Specificity
- Confusion Matrices

---

# Results

> This section will include:

- Classification accuracies
- Confusion matrices
- Decision trees
- Performance comparison tables

---

## Results Overview

The evaluated machine learning models demonstrated the feasibility of decoding lower-limb motor activity from EEG signals. Model performance was assessed across multiple binary classification tasks using a consistent cross-validation strategy.

<p align="center">
  <img src="assets/images/results-overview2.png"
       alt="Results Overview"
       width="100%">
</p>

<p align="center">
<i><b>Figure 5.</b> Summary of the machine learning performance across the evaluated classification tasks, including model comparison, representative confusion matrices, and key findings.</i>
</p>

---

# Neurophysiological Analysis

The project also investigated:

- Power Spectral Density
- Time-Frequency Analysis
- ERD/ERS Maps
- Topographic Brain Maps

These analyses provided physiological interpretation beyond classification performance.

---

# Skills Demonstrated

| Skill | Evidence |
|--------|----------|
| Biomedical Signal Processing | EEG preprocessing pipeline |
| Data Cleaning | Filtering and artifact reduction |
| Feature Engineering | Frequency-domain feature extraction |
| Machine Learning | Decision Trees and LDA |
| Model Validation | 5-Fold Cross Validation |
| Data Visualization | Spectral analysis and topographic maps |
| MATLAB Programming | Complete analytical pipeline |
| Experimental Design | EEG acquisition protocol |
| Technical Documentation | GitHub project documentation |

---

# Repository Structure

```text
.
├── assets/
│   └── images/
├── data/
├── figures/
├── notebooks/
├── references/
├── report/
├── README.md
└── PROJECT_PLAN.md
```

---

# Future Work

Potential improvements include:

- Evaluation using larger datasets.
- Deep learning approaches.
- Subject-independent classification.
- Real-time BCI implementation.
- Additional feature selection techniques.

---

# Why This Repository Is Part of My Portfolio

This project represents one of my first complete biomedical data analytics workflows.

It demonstrates how raw physiological signals can be transformed into meaningful information through reproducible preprocessing, feature engineering, statistical analysis, and machine learning.

Beyond the classification models themselves, this repository reflects my approach to documenting analytical workflows in a clear, organized, and reproducible manner.

---

# Acknowledgments

This project was developed as part of the Design and Development in Neuroengineering course at Tecnológico de Monterrey.

---

# References

*(To be completed with the scientific articles used throughout the project.)*