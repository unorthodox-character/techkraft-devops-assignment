# ----------  Stage 1 (build) ----------

FROM python:3.11-slim AS builder

WORKDIR /app

COPY requirements.txt .

RUN pip install --upgrade pip

RUN pip install --prefix=/install -r requirements.txt

COPY . .

# ----------  Stage 2 ----------

FROM python:3.11-slim

RUN addgroup --system appgroup && \
    adduser --system appuser --ingroup appgroup

WORKDIR /app

COPY --from=builder /install /usr/local

COPY app.py .

RUN chown -R appuser:appgroup /app

USER appuser

EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s \
CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/health')"

CMD ["python","app.py"]
