import numpy as np
import matplotlib.pyplot as plt
from astropy.cosmology import FlatLambdaCDM

# Define the cosmological model with Hubble constant and matter density
cosmo = FlatLambdaCDM(H0=70, Om0=0.3)

# Create an array of redshift values, including z = 0
z_values = np.linspace(0, 10, 100)

# Calculate the corresponding age of the universe at each redshift in billion years
ages = cosmo.age(z_values).value  # Age in Gyr (billion years)

# Adjust the plot to display numeric values on the y-axis instead of powers of 10
plt.figure(figsize=(8, 5))
plt.plot(z_values, ages, label="Age of the Universe vs Redshift", color='blue')
plt.scatter([0], [13.8], color='red', label='Present Day (z=0)')  # Highlight the point for z=0
plt.xlabel('Redshift (z)')
plt.ylabel('Age of the Universe (billion years)')
plt.yscale('log')  # Use logarithmic scale for better visualization
plt.yticks([0.1, 0.5, 1, 2, 5, 10, 13.8], ['0.1', '0.5', '1', '2', '5', '10', '13.8'])  # Custom y-tick values
plt.title('Age of the Universe at Different Redshifts (Log Scale)')
plt.grid(True, which='both', linestyle='--', linewidth=0.5)
plt.legend()
plt.show()
