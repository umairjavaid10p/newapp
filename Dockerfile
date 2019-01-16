### STAGE 1: Build ###
# FROM node:10.9.0-alpine as builder
# ARG ENV=dev
# COPY package.json package-lock.json ./
# ## Storing node modules on a separate layer will prevent unnecessary npm installs at each build
# RUN npm i && mkdir /ng-app && cp -R ./node_modules ./ng-app
# WORKDIR /ng-app
# COPY . .
# ## Build the angular app in production mode and store the artifacts in dist folder
# RUN $(npm bin)/ng build -c=${ENV} --prod --vendor-chunk --common-chunk --extract-css

### STAGE 2: Setup ###
FROM nginx:1.15.0-alpine
# ARG ENV=dev
## Copy our default nginx nginx
COPY nginx/dev.conf /etc/nginx/conf.d/base.conf
## From 'builder' stage copy over the artifacts in dist folder to default nginx public folder
COPY ./dist/connect /var/www/app
COPY robots.txt /var/www/app/
CMD ["nginx", "-g", "daemon off;"]
