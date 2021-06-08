FROM nginx:1.13

ARG USER_USERNAME
ARG USER_UID
ARG USER_GID
ARG DOCKER_FRONTEND_HOST
ARG DOCKER_BACKEND_HOST
ARG DOCKER_SPA_HOST

# Fix permission between host and guest
RUN addgroup --gid $USER_GID $USER_USERNAME
RUN adduser --gecos "" --disabled-password --gid $USER_GID --uid $USER_UID $USER_USERNAME

RUN sed -i -e "s/user\s\+nginx;/user $USER_USERNAME;/" /etc/nginx/nginx.conf

COPY conf.d/app.conf /etc/nginx/conf.d/app.conf
RUN sed -i -e "s/DOCKER_FRONTEND_HOST/$DOCKER_FRONTEND_HOST/" /etc/nginx/conf.d/app.conf
RUN sed -i -e "s/DOCKER_BACKEND_HOST/$DOCKER_BACKEND_HOST/" /etc/nginx/conf.d/app.conf
RUN sed -i -e "s/DOCKER_SPA_HOST/$DOCKER_SPA_HOST/" /etc/nginx/conf.d/app.conf

CMD ["nginx", "-g", "daemon off;"]