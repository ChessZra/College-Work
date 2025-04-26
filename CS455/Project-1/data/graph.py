import pandas as pd
import matplotlib.pyplot as plt

# Generate computation time plot
plt.figure(figsize=(10, 6))
threads = [1, 2, 4, 8, 16]

for n in threads:
    df = pd.read_csv(f'fluid-{n}.csv')
    plt.plot(df['Timestep'], df['SimStepTime'], label=f'{n} Threads', alpha=0.7)

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
threads = [1, 2, 4, 8, 16]

for n in threads:
    df = pd.read_csv(f'fluid-{n}.csv')
    # Calculate total parallel time including all components
    total_time = (df['SimStepTime'] + df['ImageConversionTime'] + df['ImageWriteTime']).sum()
    speedups.append(T_serial / total_time)

plt.figure(figsize=(10, 6))
plt.plot(threads, speedups, 'o-', color='tab:blue')
plt.xticks(threads)
plt.xlabel('Number of Threads')
plt.ylabel('Speedup')
plt.title('Speedup vs. Number of Threads')
plt.yticks(speedups, [f'{s:.1f}x' for s in speedups])  # Format y-axis as multipliers
plt.grid(True)
plt.savefig('speedup.png', bbox_inches='tight')
plt.close()
