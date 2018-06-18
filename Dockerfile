FROM node:carbon-alpine

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json yarn.lock ./

RUN yarn
# If you are building your code for production
# RUN npm install --only=production

# Bundle app source
COPY . .

VOLUME [ "/usr/src/app/public/certbot_webroot", "/etc/letsencrypt", "/usr/src/app/public/static_rw" ]

EXPOSE 8080 8443
CMD [ "node", "server.js" ]
