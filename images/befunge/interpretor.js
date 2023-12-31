const Befunge = require('befunge93');
const fs = require('fs');
const path = require('path');
const directoryPath = process.argv[2];

if (!directoryPath) {
  console.error('Could you please provide a directory path?');
  process.exit(1);
}

fs.readdir(directoryPath, (err, files) => {
  if (err) {
    console.error(err);
    return;
  }

  files.forEach(file => {
    if (path.extname(file) === '.bf') {
      const filePath = path.join(directoryPath, file);

      fs.readFile(filePath, 'utf8', (err, code) => {
        if (err) {
          console.error(err);
          return;
        }

        let befunge = new Befunge();
        befunge.run(code)
            .then((output) => {
                process.stdout.write(output);
            });
      });
    }
  });
});
