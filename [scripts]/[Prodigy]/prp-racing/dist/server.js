const crypto = require('crypto');

function hashString(data) {
  return crypto.createHash('sha256').update(data).digest('hex');
}

exports('HashString', hashString);