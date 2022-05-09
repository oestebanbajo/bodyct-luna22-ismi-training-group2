# LUNA 22 prequel

This challenge contains a public training dataset of lung nodules extracted from the LIDC-IDRI dataset. This dataset only contains 3D patches of nodules (size 128x128x64 in x,y,z directions) that had been annotated by at least 3 out of 4 radiologists (following LUNA16 criteria, which produces 1186 nodules). The nodules are always located at the center of the 3D patch. 10 nodules have been excluded as part of a hidden test set for phase 1. 

To collect the labels for each nodules, you will have to read the `LIDC-IDRI_1176.npy` file. An example snippet is below:

```python
import numpy as np

dataset = np.load("LIDC-IDRI_1176.npy", allow_pickle=True)

for i in range(len(dataset)):
    nodule = dataset[i]
    print(nodule)
    break
```
This produces the following output:
```
{
    'SeriesInstanceUID': '1.3.6.1.4.1.14519.5.2.1.6279.6001.100225287222365663678666836860',
    'VoxelCoordX': 45,
    'VoxelCoordY': 211,
    'VoxelCoordZ': 77,
    'Diameter': [6.97167141, 6.97167141, 7.34878692, 5.94228451],
    'Texture': [5, 5, 5, 5],
    'Malignancy': [4, 2, 4, 2],
    'Calcification': [6, 6, 6, 6],
    'Filename': '1.3.6.1.4.1.14519.5.2.1.6279.6001.100225287222365663678666836860_45_211_77_0000.nii.gz'
}
```
You can likewise loop through the entire list of 1176 nodules to find the information in the fields. 

You can find additional information for some of the fields below:

### Nodule Type (Texture)
```
int, range = {1,2,3,4,5} – Radiographic solidity: internal texture (solid, ground glass, or mixed).

1. Non-Solid/GGO
2. Non-Solid/Mixed
3. Part Solid/Mixed
4. Solid/Mixed
5. Solid
```
You may want to reduce these into 3 classes: `1. Non-solid/ GGO`, `2. (Non-solid/Mixed, Part-solid/Mixed, Solid/Mixed)`, and `3. Solid`

### Malignancy
```
int, range = {1,2,3,4,5} – Subjective assessment of the likelihood of malignancy, 
assuming the scan originated from a 60-year-old male smoker.

1. Highly Unlikely
2. Moderately Unlikely
3. Indeterminate
4. Moderately Suspicious
5. Highly Suspicious
```
You may want to combine the classes like in the previous section. Perhaps combine classes 1. and 2. as benign, and 3., 4., and 5. as malignant into a binary classification problem. 

**NOTE:** You will most definitely have to combine the classes and convert them into a binary classification or a multi-class classification problem by combining the labels provided by each radiologist (using a median score for each field is recommended)
