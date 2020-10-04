FROM node:10

COPY . .

RUN npm install

EXPOSE 4000

CMD [ "npm", "run", "serve" ]
