FROM python:3.6

WORKDIR /workspace
ADD . /workspace

RUN pip install pipenv==2018.10.13 \
    && pipenv install

CMD ["bash"]
