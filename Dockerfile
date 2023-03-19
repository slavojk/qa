FROM alpine

RUN apk add --no-cache --no-progress coreutils git bash && mkdir app/
COPY *sh app/ 
WORKDIR "/app"
RUN chmod +x *sh
CMD ["bash", "./qa.sh"]
