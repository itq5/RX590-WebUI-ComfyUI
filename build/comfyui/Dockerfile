FROM ulyssesrr/rocm-xtra-pytorch:rocm5.5.1_ubuntu22.04_pytorch2.0.1
RUN --mount=type=cache,target=/var/cache/apt,rw --mount=type=cache,target=/var/lib/apt,rw \
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    git \
    python3-venv \
    libpng16-16 \
    libjpeg-turbo8 \
    google-perftools \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /

RUN git clone https://github.com/arlo-phoenix/bitsandbytes-rocm-5.6 /bitsandbytes && \
    cd /bitsandbytes && \
    git checkout 62353b0200b8557026c176e74ac48b84b953a854 && \
    make hip ROCM_TARGET=gfx803,gfx900,gfx906,gfx908,gfx90a,gfx1030,gfx1100,gfx1101,gfx940 ROCM_HOME=/opt/rocm/ && \
    pip install . 

# To upgrade to the higher version, you need to wait for the problem to be resolved
# https://github.com/abetlen/llama-cpp-python/issues/1481
ENV LLAMA_CPP_PYTHON_VERSION=0.2.56
RUN CMAKE_ARGS="-DLLAMA_HIPBLAS=ON \
        -DCMAKE_C_COMPILER=/opt/rocm/llvm/bin/clang \
        -DCMAKE_CXX_COMPILER=/opt/rocm/llvm/bin/clang++ \
        -DAMDGPU_TARGETS=gfx803;gfx900;gfx906;gfx908;gfx90a;gfx1030;gfx1100;gfx1101;gfx940" \
        pip install llama-cpp-python==0.2.56

WORKDIR /app

RUN git clone https://github.com/comfyanonymous/ComfyUI /comfyui && \
    cd /comfyui && \
    pip install -r requirements.txt

RUN git clone https://github.com/ltdrdata/ComfyUI-Manager /comfyui/custom_nodes/ComfyUI-Manager

WORKDIR /comfui
    
SHELL ["/bin/bash", "-c"]

RUN python3 -m venv venv --system-site-packages

RUN source venv/bin/activate

RUN pip install -r requirements.txt

ENV PYTHONUNBUFFERED=1
EXPOSE 7861

ENTRYPOINT ["python3", "main.py", "--listen", "0.0.0.0", "--port", "7861"]