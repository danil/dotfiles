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
    { name: "Bike" },
    { name: "DanilMed" },
    { name: "DisqusFeeds" },
    { name: "ErA5gComAh9" },
    { name: "ErA5gComBh1" },
    { name: "ErArmor5games" },
    { name: "ErArmor5gamesNew" },
    { name: "ErBrokerhub" },
    { name: "ErJohnru" },
    { name: "ErMiiix" },
    { name: "ErMolinos" },
    { name: "ErOzon" },
    { name: "ErProhq" },
    { name: "ErQiwi" },
    { name: "ErRocketbank" },
    { name: "ErWaveaccess" },
    { name: "ErXena" },
    { name: "EximLists" },
    { name: "Fail2Ban" },
    { name: "FsfLists" },
    { name: "GentooCommunity" },
    { name: "GentooUsers" },
    { name: "GolangRuList" },
    { name: "GolangRuList2New" },
    { name: "GolangRuListNew" },
    { name: "HondaCRV2012" },
    { name: "HrFredVacancy" },
    { name: "HrGolangVacancy" },
    { name: "HrJsVacancy" },
    { name: "HrRubyVacancy" },
    { name: "HrVacancy" },
    { name: "Jamendo" },
    { name: "JollaCommunity" },
    { name: "KutOrgH10" },
    { name: "KutOrgH2" },
    { name: "LeraMed" },
    { name: "Lists" },
    { name: "LuaFeeds" },
    { name: "Luadns" },
    { name: "Mailspring" },
    { name: "Mailspring/Snoozed" },
    { name: "Offline" },
    { name: "PostgreSqlList" },
    { name: "Receipt" },
    { name: "Redfox" },
    { name: "RedisList" },
    { name: "Registr" },
    { name: "Roman" },
    { name: "Ror2ruList" },
    { name: "Ror2ruList2" },
    { name: "Ror2ruList2New" },
    { name: "Ror2ruListNew" },
    { name: "RustRussianList" },
    { name: "RustyCrateRuList" },
    { name: "Schedule" },
    { name: "ScyllaDBList" },
    { name: "SoftwaremaniacsOrgFeed" },
    { name: "SucklessDevList" },
    { name: "Twitter2" },
    { name: "TwitterOld" },
    { name: "VcRu" },
    { name: "VimList" },
    { name: "YoutubeFeeds" },
    { name: "_new" },
    { name: "_trash" },
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
      actions: {
        archive: true,
        labels: [ "VimList" ],
      }
    }, {
      filter: {
        list: "scylladb-dev.googlegroups.com",
      },
      actions: {
        archive: true,
        labels: [ "ScyllaDBList" ],
      }
    }, {
      filter: { from: "noreply@vc.ru" },
      actions: {
        archive: true,
        labels: [ "VcRu" ],
      },
    }, {
      filter: {
        and: [
          { from: "usercommunication@tutu.ru" },
          { subject: "Туту.ру: чек" },
        ]
      },
      actions: {
        archive: true,
        labels: [ "Receipt" ],
      },
    },
    // {
    //   filter: {
    //     and: [ notToMe ],
    //   },
    //   actions: {
    //     archive: true,
    //     labels: [ "_new" ]
    //   }
    // }
  ]
}
