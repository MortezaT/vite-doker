FROM node:18-slim as builder

RUN npm i -g pnpm
WORKDIR /app

COPY package.json pnpm-lock.yaml? ./
RUN pnpm install

COPY . .


FROM builder as dev
EXPOSE 5173
CMD [ "pnpm", "run", "dev" ]

FROM builder as production
RUN pnpm run build
EXPOSE 4173
# RUN pnpm run preview
CMD [ "pnpm", "run", "preview" ]