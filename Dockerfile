FROM node:10

COPY . .

RUN npm install

EXPOSE 8080

CMD [ "npm", "run", "serve" ]
