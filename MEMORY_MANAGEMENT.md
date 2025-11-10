# Memory Management Configuration for Odino

If you're experiencing MPS (Metal Performance Shaders) memory issues on Apple Silicon, you can customize these settings in your `.odino/config.json` file:

## Key Configuration Options

### 1. Embedding Batch Size
Control how many text chunks are processed at once for embeddings:

```json
{
  "embedding_batch_size": 16
}
```

- **Default**: 32 for MPS, 1000 for other devices
- **For MPS issues**: Try 16, 8, or even 4 for very large models
- **Lower values**: Use less memory but process slower

### 2. Device Preference
Force the use of a specific device:

```json
{
  "device_preference": "cpu"
}
```

- **auto** (default): Automatically select best available device
- **cpu**: Force CPU usage (most stable, slowest)
- **mps**: Force MPS (Apple Silicon GPU, fastest but memory intensive)
- **cuda**: Force CUDA (NVIDIA GPU)

### 3. Recommended Settings for MPS Issues

If you frequently encounter MPS out of memory errors, try this configuration:

```json
{
  "embedding_batch_size": 16,
  "device_preference": "auto"
}
```

Or to completely avoid MPS memory issues:

```json
{
  "embedding_batch_size": 64,
  "device_preference": "cpu"
}
```

## Environment Variables

The system automatically sets `PYTORCH_MPS_HIGH_WATERMARK_RATIO=0.0` to disable MPS memory limits. This is handled internally and doesn't require user configuration.

## Memory Management Features

The updated indexer includes several memory management improvements:

1. **Automatic batch processing**: Embeddings are generated in configurable batches
2. **MPS memory clearing**: Memory is cleared after each batch when using MPS
3. **Automatic CPU fallback**: If MPS runs out of memory, automatically falls back to CPU
4. **Device detection**: Automatically selects the best available device
5. **Memory-efficient model loading**: Models are loaded with proper device specification

## Troubleshooting

### Still getting MPS errors?
1. Reduce `embedding_batch_size` to 8 or 4
2. Set `device_preference` to `"cpu"`
3. Restart your Python session to clear GPU memory

### Want faster processing?
1. Increase `embedding_batch_size` (if you have enough memory)
2. Set `device_preference` to `"mps"` (if you have Apple Silicon)
3. Ensure no other GPU-intensive applications are running

### Need to monitor memory usage?
The indexer will display:
- Which device is being used
- Batch processing progress
- Memory fallback notifications
- Device switching notifications