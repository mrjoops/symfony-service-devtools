FROM mrjoops/ppm:7.3.9-ci

ADD . .

RUN composer install -no --no-dev --prefer-dist

FROM mrjoops/ppm:7.3.9

ENV APP_DEBUG 0
ENV APP_ENV prod

COPY --from=0 /app .
