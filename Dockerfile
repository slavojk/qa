FROM alpine

RUN apk add --no-cache --no-progress coreutils git
COPY *sh .
CMD ["qa.sh"]
