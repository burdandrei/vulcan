FROM alpine AS builder

COPY vulcan.c ./

RUN apk update \
	&& apk add hiredis-dev gcc libc-dev

RUN	gcc -pthread  vulcan.c -lhiredis -o vulcan

FROM alpine:latest
RUN apk update \
	&& apk add hiredis-dev

COPY --from=builder /vulcan .
CMD ["./vulcan"]
