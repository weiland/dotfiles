const { execSync } = require('child_process');
const { writeFileSync, lstatSync } = require('fs');
const { join } = require('path');

const name = 'Pascal Weiland';
const licenseName = 'P Weiland';
const email = 'pasweiland@gmail.com';
const gitHubUsername = 'weiland';
const mainFile = 'index.js';

const ecContent = `# editorconfig.org

root = true

[*]
charset = utf-8
end_of_line = lf
indent_size = 2
indent_style = space
insert_final_newline = true
trim_trailing_whitespace = true

[*.md]
trim_trailing_whitespace = false

[Makefile]
indent_style = tab
`;
const giContent = `node_modules

.DS_Store
npm-debug.log*
.idea
`;
const gaContent = `* text=auto`;
const erContent = `{
  "root": true,
  "env": {
      "browser": true,
      "node": true,
      "es6": true
  },
  "extends": [
    "airbnb-base",
      "plugin:prettier/recommended",
      "plugin:security/recommended",
      "plugin:promise/recommended",
      "plugin:unicorn/recommended",
      "plugin:sonarjs/recommended"
  ],
  "plugins": [
    "prettier",
    "security",
    "sonarjs",
    "promise"
  ],
  "rules": {
    "prettier/prettier": "error"
  }
}
`;
const prContent = `{
  "printWidth": 80,
  "tabWidth": 2,
  "useTabs": false,
  "semi": true,
  "singleQuote": true,
  "trailingComma": "all"
}
`;
const piContent = `node_modules/
package-lock.json
package.json
yarn.lock
`;
const nrContent = 'lts/erbium'; // Version 12

const liContent = `
The ISC License (ISC)

Copyright (c) ${(new Date()).getFullYear()}, P Weiland

Permission to use, copy, modify, and/or distribute this software for
any purpose with or without fee is hereby granted, provided that the
above copyright notice and this permission notice appear in all
copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
`;


const cwd = process.cwd();

console.debug(basename, package.name, package);

let projectName = cwd.split('/').pop() || basename || package.name;


const run = (func) => {
  console.log(execSync(func).toString())
}

const createFile = (name, content) => {
  try {
      lstatSync(join(cwd,  name));
  } catch(err) {
      writeFileSync(join(cwd, name), content)
  }
};

writeFileSync(mainFile, `const main = () => {
  console.log('hello');
}
`);
writeFileSync('test.js', '');
// run('touch Makefile');

writeFileSync('.editorconfig', ecContent);
writeFileSync('.gitignore', giContent);
writeFileSync('.gitattributes', gaContent);
// run('npx gitignore node');

writeFileSync('.eslintrc.json', erContent);
writeFileSync('.prettierrc.json', prContent);
writeFileSync('.prettierignore', piContent);

writeFileSync('.nvmrc', nrContent);

// run(`npx license ISC -n '${name}' -e '${email}'`);
writeFileSync('license.md', liContent);

writeFileSync('readme.md', `# ${projectName} 
`);

module.exports = {
  name: prompt('package name', projectName, (name) => {
    projectName = name;
    return name;
  }),
  version: '0.0.1',
  decription: 'TODO',
  main: mainFile,
  keywords: '',
  scripts: {
    start: `node ${mainFile}`,
    test: 'node test.js'
  },
  author: `${name} ${email}`,
  homepage: `https://github.com/${gitHubUsername}/${projectName}#readme`,
  bugs: `https://github.com/${gitHubUsername}/${projectName}/issues`,
  license: 'ISC',
  repository: prompt('github repository url', `https://github.com/${gitHubUsername}/${projectName}`, (url) => {
    run('git init');
    run('git add -A');
    // run('git commit -m ":octocat: Initial commit"');
    return url;
  }),
}
