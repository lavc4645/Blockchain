const PlayerNew = artifacts.require("PlayerNew");

module.exports = (deployer) => {
  var parentContractAddress = "0xD3972B742a47acF7b34d3D15925dD534eC8aFB99";
  var defaultPlayer = "0x5103D9A69052bf3Fd80222622a3b1C0FdfF391e0";
  var bal = 100;
  deployer.deploy(PlayerNew, parentContractAddress,defaultPlayer,bal);
};
