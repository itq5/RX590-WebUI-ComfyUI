# Intro

Stable Diffusion Web UIs Docker Image for ROCm AMD.

Includes AUTOMATIC1111's [Stable-Diffusion-WebUI](https://github.com/AUTOMATIC1111/stable-diffusion-webui) v1.10.0 and [ComfyUI](https://github.com/comfyanonymous/ComfyUI).

Based on the work of [ulyssesrr](https://github.com/ulyssesrr/docker-rocm-xtra/)

Optimized for low vram usage.
Tested on a RX570 4GB (896 x 1152 = 25s/it or batch of 4 = 55s/it)

if you still have vram problems, try to reduce the resolution or :
    - Use sdxl-vae-fp16-fix; a VAE that will not need to run in fp32. This will increase speed and lessen VRAM usage at almost no quality loss.
    - Use TAESD; a VAE that uses drastically less vram at the cost of some quality.

txt2img speed is much faster on ComfyUI.

Both WebUI share the models LORAs and VAE folders.

Outputs folder are also redirected to an instance of [Infinite Image Browser](https://github.com/zanllp/sd-webui-infinite-image-browsing)

# Usage

Clone the repo and use `docker compose up` to start the container.

- Stable-Diffusion-WebUI (AUTOMATIC1111): http://localhost:7860
- ComfyUI: http://localhost:7861
- Infinite Image Browser: http://localhost:7862

I usualy use SD-WebUI to download civitai models/LORAs, do some quick low-res tests, then move to ComfyUI for higher res and batch processing overnight. I can then browse both folders in IIB.

# TODO

- find a way to run batches in ComfyUI with the browser closed, like in SD-WebUI.