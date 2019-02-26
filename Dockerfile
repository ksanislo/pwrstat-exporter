FROM python:3.7
EXPOSE 9546
RUN groupadd --gid 5001 pwrstat-exporter && useradd --no-log-init --no-create-home --home-dir /usr/src/pwrstat-exporter --uid 5001 --gid 5001 --shell /bin/false pwrstat-exporter
RUN mkdir -p /usr/src/pwrstat-exporter && chown pwrstat-exporter:pwrstat-exporter /usr/src/pwrstat-exporter
RUN mkdir -p /var/log/pwrstat-exporter && chown pwrstat-exporter:pwrstat-exporter /var/log/pwrstat-exporter
WORKDIR /usr/src/pwrstat-exporter
RUN wget -O powerpanel.deb https://dl4jz3rbrsfum.cloudfront.net/software/powerpanel_132_amd64.deb
RUN dpkg -i powerpanel.deb
RUN pip install dumb-init
ENTRYPOINT ["dumb-init", "--"]
CMD ["bash", "/usr/src/pwrstat-exporter/startup.sh"]
COPY --chown=pwrstat-exporter:pwrstat-exporter startup.sh /usr/src/pwrstat-exporter/
COPY --chown=pwrstat-exporter:pwrstat-exporter definitions.json /usr/src/pwrstat-exporter/
COPY --chown=pwrstat-exporter:pwrstat-exporter pwrstat-exporter /usr/src/pwrstat-exporter/
RUN python -OO -m py_compile pwrstat-exporter
