FROM mhart/alpine-node
# FROM node:14.4.0-stretch-slim
  
COPY . /app


CMD node /app/app.js

EXPOSE  3000
