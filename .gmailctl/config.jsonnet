// Import the standard library
local lib = import 'gmailctl.libsonnet';

// Local variables help reuse config fragments.
local toMe = {
  or: [
    { to: "danil@kutkevich.org" },
    { to: "danil@kutkevich.ru" },
    { to: "danil2@kutkevich.org" },
    { to: "danilkutkevich@gmail.com" },
    { to: "danilkutkevich@mail.ru" },
    { to: "danilkutkevich@yandex.ru" },
  ],
};

local notToMe = { not: toMe };

local fromMe = {
  or: [
    { from: "danil@kutkevich.org" },
    { from: "danil@kutkevich.ru" },
    { from: "danil2@kutkevich.org" },
    { from: "danilkutkevich@gmail.com" },
    { from: "danilkutkevich@mail.ru" },
    { from: "danilkutkevich@yandex.ru" },
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
    { name: "Fed" },
    { name: "FedCloudflare" },
    { name: "FedDisqus" },
    { name: "FedGithub" },
    { name: "FedGolang" },
    { name: "FedGoogle" },
    { name: "FedHabr" },
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
    { name: "LstGolang" },
    { name: "LstGolangRu" },
    { name: "LstGolangRuNew" },
    { name: "LstGolangRuNew2" },
    { name: "LstPostgreSql" },
    { name: "LstRedis" },
    { name: "LstRustRussian" },
    { name: "LstRustyCrateRu" },
    { name: "LstScyllaDb" },
    { name: "LstSuckless" },
    { name: "LstTmux" },
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
    { name: "xARC" },
    { name: "xARC/_new" },
    { name: "xARC/_xInboxBackupNew" },
    { name: "xARC/_xSentBackupNew" },
    { name: "xARC/_xxArchiveBackupNew" },
  ],
  rules: [
    {
      filter: {
        and: [
          { from: "noreply@github.com" },
          { subject: "GitHub Explore" },
        ],
      },
      actions: { labels: [ "FedGithub" ], archive: true, },
    }, {
      filter: {
        or: [
          { to: "tmux-users@googlegroups.com" },
          { from: "tmux-users@googlegroups.com" },
          { list: "tmux-users@googlegroups.com" },
          { list: "tmux-users.googlegroups.com" },
        ],
      },
      actions: { labels: [ "LstTmux" ], archive: true, },
    }, {
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
      filter: {
        or: [
          { to: "dev@suckless.org" },
          { list: "dev.suckless.org" },
        ],
      },
      actions: { labels: [ "LstSuckless" ], archive: true, },
    }, {
      filter: {
        or: [
          { to: "go@noreply.github.com" },
          { list: "go.golang.github.com" },
        ],
      },
      actions: { labels: [ "LstGolang" ], archive: true, },
    }, {
      filter: {
        or: [
          { from: "golang-dev@googlegroups.com" },
          { to: "golang-dev@googlegroups.com" },
          { list: "golang-dev.googlegroups.com" },
        ],
      },
      actions: { labels: [ "LstGolang" ], archive: true, },
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
      filter: {
        and: [
          { from: "noreply@habr.com" },
          { or: [
            { subject: "Мы знаем" },
            { subject: "Самое важное" },
            { subject: "Самое интересное" },
          ], },
        ],
      },
      actions: { labels: [ "FedHabr" ], archive: true, },
    }, {
      filter:  { from: "noreply@vc.ru" },
      actions: { labels: [ "FedVcRu" ], archive: true, },
    }, {
      filter: { from: "newsletter@cloudflare.com" },
      actions: { labels: [ "FedCloudflare" ], archive: true, },
    }, {
      filter:  {
        or: [
          { from: "noreply-maps-timeline@google.com" },
        ],
      },
      actions: { labels: [ "FedGoogle" ], archive: true, },
    }, {
      filter:  {
        or: [
          { from: "noreply@ip2location.com" },
        ],
      },
      actions: { labels: [ "Fed" ], archive: true, },
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
