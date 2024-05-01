import numpy as np
import pandas as pd
from sklearn.svm import SVC
import matplotlib.pyplot as plt
from sklearn.utils import shuffle
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split


# This is for scatter plot of input
def plot_input(x, y):
    x0n, x1n, x0p, x1p = [], [], [], []

    for i in range(len(x)):
        if y[i] == -1:
            x0n.append(x[i][0])
            x1n.append(x[i][1])
        else:
            x0p.append(x[i][0])
            x1p.append(x[i][1])

    # print(x0n, x1n, x0p, x1p, sep='\n\n')
    # plt.scatter(x0n, x1n, color='#549E39')
    # plt.scatter(x0p, x1p, color='#6325BD')

    plt.scatter(x0n, x1n, label='output = control (-1)', c='#549E39', marker='o', s=100, edgecolors='black', alpha=0.4)

    plt.scatter(x0p, x1p, label='output = memory (+1) ', c='#6325BD', marker='s', s=100, edgecolors='black', alpha=0.4)

    plt.title('Input Data Scatter Plot: Average Frequency Band Power')
    plt.xlabel('Alpha (9-14 Hz) Power at Pz, P1, P2, P3, P4  →')
    plt.ylabel('Theta (4-8 Hz) Power at Fz  →')
    plt.legend()
    plt.grid()
    plt.show()


# Specify the file path (adjust if needed)
file_path = "Features.xlsx"

# Read the first sheet using pandas.read_excel() with sheet_name=0 (zero-based indexing)
df = pd.read_excel(file_path, sheet_name=0)
df = shuffle(df, random_state=5)
# print(df)

# Selecting columns by header name
df = df[["condition", "freqBandPowerThetaFz", "freqBandPowerAlphaMean"]]
# print(df)

# Creating x array using list comprehension
x = np.array([[float(df.loc[i, 'freqBandPowerThetaFz']), float(df.loc[i, 'freqBandPowerAlphaMean'])] for i in df.index])


# Creating y array using list comprehension
y = np.array([-1 if val == 'control' else 1 for val in df['condition']])


# Printing the arrays
# print("Datatype Features:\n", type(x))
# print("Datatype Features List:\n", type(x[0]))
# print("Datatype Features List Value:\n", type(x[0][0]))
# print("Datatype expected Outcome:\n", type(y))
# print("Datatype expected Outcome Value:\n", type(y[0]))
# print("Features:\n", x)
# print("Expected Outcome:\n", y)

# plot_input(x, y)

# Standardizing features
x = StandardScaler().fit_transform(x)

# Allocate 25% of the data for testing (test_size=0.25)
x_train, x_test, y_train, y_test = train_test_split(x, y, stratify=y, test_size=0.25, random_state=1)


# Creating the SVM model with RBF kernel
model = SVC(kernel='rbf', C=0.2, gamma=1.0, probability=True)

# Training the model
model.fit(x_train, y_train)

# Calculating Accuracy
accuracy = model.score(x_test, y_test)
print('\nAccuracy: {} %'.format(accuracy*100))
