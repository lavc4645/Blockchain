var http = require('http'); // Import Node.js core module


const Web3 = require("web3"); // const getWeb3 = require('./utils.js');


var server = http.createServer(function (req, res) {
  const web3 = new Web3('https://rinkeby.infura.io/v3/0e8622ff78a04db4beff04c5a80583a1');
  web3.eth.getBalance("0xBAc049334F5884F0e7675339D551585464a6B798", function (err, result) {
    if (err) {
      console.log(err);
    } else {
      console.log(web3.utils.fromWei(result, "ether") + " ETH");
    }
  });

  if (req.url == '/') {
    //check the URL of the current request
    // set response header
    res.writeHead(200, {
      'Content-Type': 'text/html'
    }); // set response content    

    res.write('<html><body><p>This is home Page.</p></body></html>');
    res.end();
  } else res.end('Invalid Request!');
});
server.listen(5001); //6 - listen for any incoming requests

console.log('Node.js web server at port 5001 is running..');