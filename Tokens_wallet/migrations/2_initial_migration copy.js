const SharedTokenWallet = artifacts.require("SharedTokenWallet");

module.exports = function (deployer) {
  deployer.deploy(SharedTokenWallet);
};
