# Intro

Stable Diffusion Web UIs Docker Image for ROCm AMD.

Includes AUTOMATIC1111's Stable-Diffusion-WebUI v1.10.0 and ComfyUI.

Based on the work of [ulyssesrr](https://github.com/ulyssesrr/docker-rocm-xtra/)

Optimized for low vram usage.
Tested on a RX570 4GB (896 x 1152 = 25s/it or batch of 4 = 55s/it)

if you still have vram problems, try to reduce the resolution or :
    - Use sdxl-vae-fp16-fix; a VAE that will not need to run in fp32. This will increase speed and lessen VRAM usage at almost no quality loss.
    - Use TAESD; a VAE that uses drastically less vram at the cost of some quality.

Both WebUI share the models folder, so you can use the same models for both.

# Usage

Clone the repo and use `docker compose up` to start the container.

- Stable-Diffusion-WebUI (AUTOMATIC1111): http://localhost:7860
- ComfyUI: http://localhost:7861