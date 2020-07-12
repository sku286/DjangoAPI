FROM python:3.8.2

#MAINTANER Nagarro

RUN mkdir -p /src
RUN mkdir -p /src/pip_cache
WORKDIR /src

RUN apt-get update -y && apt-get dist-upgrade -y
RUN apt-get install -y default-libmysqlclient-dev
RUN apt-get install -y libmariadbclient-dev
RUN apt-get install -y python3-dev

#install external dependency
RUN pip install --upgrade pip
COPY requirement.txt requirement.txt
RUN pip install -r requirement.txt --cache-dir /src/pip_cache

COPY ./src /src

EXPOSE 8007
CMD ["python", "manage.py", "makemigrations"]
CMD ["python", "manage.py", "migrate"]
CMD ["gunicorn", "-b", "0.0.0.0:8007","kiwee_dashboard_api.wsgi:application"]
