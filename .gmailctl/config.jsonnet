// Import the standard library
local lib = import 'gmailctl.libsonnet';

// Local variables help reuse config fragments.
local toMe = {
  or: [
    { to: "danil@kutkevich.org" },
    { to: "danil2@kutkevich.org" },
    { to: "danilkutkevich@gmail.com" },
  ],
};

local notToMe = { not: toMe };

local fromMe = {
  or: [
    { from: "danil@kutkevich.org" },
    { from: "danil2@kutkevich.org" },
    { from: "danilkutkevich@gmail.com" },
  ],
};

local notFromMe = { not: fromMe };

{
  version: "v1alpha3",
  author: {
    name: "Danil Kutkevich",
    email: "danil@kutkevich.org"
  },
  // Note: labels management is optional. If you prefer to use the
  // GMail interface to add and remove labels, you can safely remove
  // this section of the config.
  labels: [
    { name: "ErA5g" },
    { name: "ErBro" },
    { name: "ErJon" },
    { name: "ErMix" },
    { name: "ErMol" },
    { name: "ErOzn" },
    { name: "ErPhq" },
    { name: "ErQwi" },
    { name: "ErRkt" },
    { name: "ErWac" },
    { name: "ErXen" },
    { name: "FedDisqus" },
    { name: "FedGithub" },
    { name: "FedJamendo" },
    { name: "FedLua" },
    { name: "FedLuadns" },
    { name: "FedSoftwaremaniacsOrg" },
    { name: "FedTwitter2" },
    { name: "FedTwitterOld" },
    { name: "FedVcRu" },
    { name: "FedYoutube" },
    { name: "HrFredVac" },
    { name: "HrGolangVac" },
    { name: "HrJsVac" },
    { name: "HrRubyVac" },
    { name: "HrVac" },
    { name: "KutOrgH10" },
    { name: "KutOrgH2" },
    { name: "Lst" },
    { name: "LstExim" },
    { name: "LstFsf" },
    { name: "LstGolangRu" },
    { name: "LstGolangRuNew" },
    { name: "LstGolangRuNew2" },
    { name: "LstPostgreSql" },
    { name: "LstRedis" },
    { name: "LstRustRussian" },
    { name: "LstRustyCrateRu" },
    { name: "LstScyllaDb" },
    { name: "LstSucklessDev" },
    { name: "LstVim" },
    { name: "Mailspring" },
    { name: "Mailspring/Snoozed" },
    { name: "MedDanil" },
    { name: "MedLera" },
    { name: "Offline" },
    { name: "PubBike" },
    { name: "PvtHondaCRV2012" },
    { name: "PvtRoman" },
    { name: "Receipt" },
    { name: "Registr" },
    { name: "Schedule" },
    { name: "_new" },
    { name: "_xInboxBackupNew" },
    { name: "_xSentBackupNew" },
    { name: "_xxArchiveBackupNew" },
  ],
  rules: [
    {
      filter: {
        or: [
          { to: "vim_dev@googlegroups.com" },
          { to: "vim@noreply.github.com" },
          { from: "vim_dev@googlegroups.com" },
          { replyto: "vim_dev@googlegroups.com" },
          { list: "vim_dev@googlegroups.com" },
          { list: "vim.vim.github.com" },
        ],
      },
      actions: { labels: [ "LstVim" ], archive: true, },
    }, {
      filter:  { list: "redis-db.googlegroups.com" },
      actions: { labels: [ "LstRedis" ], archive: true, },
    }, {
      filter:  {
        or: [
          { list: "scylladb-dev.googlegroups.com" },
          { list: "scylladb-users.googlegroups.com" },
        ],
      },
      actions: { labels: [ "LstScyllaDb" ], archive: true, },
    }, {
      filter:  { from: "noreply@vc.ru" },
      actions: { labels: [ "FedVcRu" ], archive: true, },
    }, {
      filter: {
        and: [
          { from: "usercommunication@tutu.ru" },
          { subject: "Туту.ру: чек" },
        ]
      },
      actions: { labels: [ "Receipt" ], archive: true, },
    },
  ]
}
