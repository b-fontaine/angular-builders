#!/usr/bin/env bash
filename=jest-builder.tgz

yarn pack --filename ${filename}
cd ./examples/simple-app && yarn add -D file:../../${filename}
yarn test
yarn e2e -- --protractor-config=./e2e/protractor-ci.conf.js
cd ../multiple-apps && yarn add -D file:../../${filename}
yarn run test my-first-app && yarn run test my-second-app && yarn run test my-shared-library
yarn run e2e my-first-app-e2e -- --protractor-config=./projects/my-first-app-e2e/protractor-ci.conf.js && yarn run e2e my-second-app-e2e -- --protractor-config=./projects/my-second-app-e2e/protractor-ci.conf.js