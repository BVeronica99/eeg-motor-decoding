# Source Code

This directory contains the complete MATLAB implementation of the EEG Motor Intent Classification project.

The source code is organized into independent modules following the analytical workflow.

---

## Folder Structure

### preprocessing/

Signal loading, preprocessing and segmentation.

- load_data.m
- build_fieldtrip_structure.m
- preprocess_signal.m
- common_average_reference.m
- epoch_data.m
- label_conditions.m

---

### analysis/

Signal analysis and feature engineering.

- frequency_analysis.m
- time_frequency_analysis.m
- compute_erd_ers.m
- plot_topographies.m
- feature_extraction.m

---

### models/

Machine learning classifiers and performance summary.

- decision_tree_models.m
- lda_models.m
- summarize_results.m

---

### utils/

Reusable helper functions.

- run_decision_tree.m
- run_lda.m