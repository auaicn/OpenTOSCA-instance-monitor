FROM python
WORKDIR /usr/src/app
COPY . /usr/src/app
RUN pip install --upgrade pip && pip install -r requirements.txt

EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]