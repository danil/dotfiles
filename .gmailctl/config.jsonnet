// Auto-imported filters by 'gmailctl download'.
//
// WARNING: This functionality is experimental. Before making any
// changes, check that no diff is detected with the remote filters by
// using the 'diff' command.

// Uncomment if you want to use the standard library.
// local lib = import 'gmailctl.libsonnet';
{
  version: "v1alpha3",
  author: {
    name: "YOUR NAME HERE (auto imported)",
    email: "your-email@gmail.com"
  },
  // Note: labels management is optional. If you prefer to use the
  // GMail interface to add and remove labels, you can safely remove
  // this section of the config.
  labels: [
    {
      name: "ErA5gComBh1"
    },
    {
      name: "Ror2ruList2"
    },
    {
      name: "_new"
    },
    {
      name: "Roman"
    },
    {
      name: "Twitter2"
    },
    {
      name: "ErArmor5gamesNew"
    },
    {
      name: "Ror2ruList2New"
    },
    {
      name: "GolangRuListNew"
    },
    {
      name: "GolangRuList2New"
    },
    {
      name: "Ror2ruListNew"
    },
    {
      name: "TwitterOld"
    },
    {
      name: "HrFredVacancy"
    },
    {
      name: "ErQiwi"
    },
    {
      name: "ErOzon"
    },
    {
      name: "HrVacancy"
    },
    {
      name: "HrGolangVacancy"
    },
    {
      name: "_xInboxBackupNew"
    },
    {
      name: "_xxArchiveBackupNew"
    },
    {
      name: "_xSentBackupNew"
    },
    {
      name: "Fail2Ban"
    },
    {
      name: "Redfox"
    },
    {
      name: "Luadns"
    },
    {
      name: "JollaCommunity"
    },
    {
      name: "RustRussianList"
    },
    {
      name: "DanilMed"
    },
    {
      name: "LeraMed"
    },
    {
      name: "FsfLists"
    },
    {
      name: "SoftwaremaniacsOrgFeed"
    },
    {
      name: "LuaFeeds"
    },
    {
      name: "_trash"
    },
    {
      name: "ErJohnru"
    },
    {
      name: "HrRubyVacancy"
    },
    {
      name: "Bike"
    },
    {
      name: "Schedule"
    },
    {
      name: "ErRocketbank"
    },
    {
      name: "Lists"
    },
    {
      name: "ErProhq"
    },
    {
      name: "ScyllaDBList"
    },
    {
      name: "PostgreSqlList"
    },
    {
      name: "VimList"
    },
    {
      name: "ErMiiix"
    },
    {
      name: "ErMolinos"
    },
    {
      name: "ErXena"
    },
    {
      name: "HondaCRV2012"
    },
    {
      name: "Registr"
    },
    {
      name: "Receipt"
    },
    {
      name: "RedisList"
    },
    {
      name: "ErWaveaccess"
    },
    {
      name: "YoutubeFeeds"
    },
    {
      name: "DisqusFeeds"
    },
    {
      name: "Jamendo"
    },
    {
      name: "Offline"
    },
    {
      name: "RustyCrateRuList"
    },
    {
      name: "GentooCommunity"
    },
    {
      name: "KutOrgH10"
    },
    {
      name: "KutOrgH2"
    },
    {
      name: "ErA5gComAh9"
    },
    {
      name: "ErArmor5games"
    },
    {
      name: "EximLists"
    },
    {
      name: "GentooUsers"
    },
    {
      name: "ErBrokerhub"
    },
    {
      name: "GolangRuList"
    },
    {
      name: "HrJsVacancy"
    },
    {
      name: "Ror2ruList"
    },
    {
      name: "SucklessDevList"
    }
  ],
  rules: [
    {
      filter: {
        from: "-(danil@kutkevich.org OR danil2@kutkevich.org)",
        isEscaped: true
      },
      actions: {
        archive: true,
        labels: [
          "_new"
        ]
      }
    }
  ]
}
