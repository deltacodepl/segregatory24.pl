FROM python:3.10.8-slim-bullseye

ARG REQUIREMENTS_FILE

WORKDIR /app
EXPOSE 80
ENV PYTHONUNBUFFERED 1

RUN set -x && \
	apt-get update && \
	apt -f install	&& \
	apt-get -qy install netcat wget && \
	rm -rf /var/lib/apt/lists/* && \
	wget -O /wait-for https://raw.githubusercontent.com/eficode/wait-for/master/wait-for && \
	chmod +x /wait-for


COPY ./docker/ /
CMD ["sh", "/entrypoint-web.sh"]

COPY ./backend/ ./
COPY ./pre-commit.example ./
RUN pip install -r ./${REQUIREMENTS_FILE}


