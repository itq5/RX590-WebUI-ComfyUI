FROM docker.7ii.win/ulyssesrr/rocm-xtra-pytorch:rocm5.5.1_ubuntu22.04_pytorch2.0.1 
RUN --mount=type=cache,target=/var/cache/apt,rw --mount=type=cache,target=/var/lib/apt,rw \
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    git \
    python3-venv \
    libpng16-16 \
    libjpeg-turbo8 \
    google-perftools \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /

RUN git clone  https://github.7ii.win/https://github.com/itq5/stable-diffusion-webui.git stable-diffusion-webui

WORKDIR /stable-diffusion-webui
    
SHELL ["/bin/bash", "-c"]

RUN python3 -m venv venv --system-site-packages

RUN source venv/bin/activate

RUN pip install -r requirements_versions.txt --index-url https://pypi.tuna.tsinghua.edu.cn/simple/
RUN pip install -r requirements.txt --index-url https://pypi.tuna.tsinghua.edu.cn/simple/

COPY rocm-xtra-setup.py .

RUN python3 rocm-xtra-setup.py --skip-torch-cuda-test

# # WORKAROUND: Fix Segmentation fault
# RUN pip install protobuf==3.18.3
# RUN pip install pydantic==1.10.7

VOLUME /root/.cache

RUN mkdir -p /stable-diffusion-webui/data
VOLUME /stable-diffusion-webui/data
VOLUME /stable-diffusion-webui/outputs

ENV PYTHONUNBUFFERED=1
EXPOSE 7860

ENTRYPOINT ["python3", "launch.py", "--data-dir", "/stable-diffusion-webui/data", "--listen", "--port", "7860"]
CMD ["--opt-sdp-no-mem-attention"]
