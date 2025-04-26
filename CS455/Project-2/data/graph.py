# Reused from project 1

import pandas as pd
import matplotlib.pyplot as plt

# Generate computation time plot
plt.figure(figsize=(10, 6))
nodes = [1, 2, 4, 8]

for n in nodes:
    df = pd.read_csv(f'fluid-{n}.csv')
    plt.plot(df['Timestep'], df['SimStepTime'], label=f'{n} nodes', alpha=0.7)

plt.xlabel('Timestep Index')
plt.ylabel('Time per Timestep (seconds)')
plt.title('Computation Time per Timestep')
plt.legend()
plt.grid(True)
plt.savefig('computation.png', bbox_inches='tight')
plt.close()

# Generate speedup plot
df_serial = pd.read_csv('fluid-1.csv')
T_serial = (df_serial['SimStepTime'] + df_serial['ImageConversionTime'] + df_serial['ImageWriteTime']).sum()
speedups = []
nodes = [1, 2, 4, 8]

for n in nodes:
    df = pd.read_csv(f'fluid-{n}.csv')
    # Calculate total parallel time including all components
    total_time = (df['SimStepTime'] + df['ImageConversionTime'] + df['ImageWriteTime']).sum()
    speedups.append(T_serial / total_time)

plt.figure(figsize=(10, 6))
plt.plot(nodes, speedups, 'o-', color='tab:blue')
plt.xticks(nodes)
plt.xlabel('Number of nodes')
plt.ylabel('Speedup')
plt.title('Speedup vs. Number of nodes')
plt.yticks(speedups, [f'{s:.1f}x' for s in speedups])  # Format y-axis as multipliers
plt.grid(True)
plt.savefig('speedup.png', bbox_inches='tight')
plt.close()
