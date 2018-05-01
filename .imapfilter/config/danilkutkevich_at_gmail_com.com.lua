-- -*- coding: utf-8-unix; -*-
function danilkutkevich_at_gmail_com_filtering()
  local trash = gmail.imapfilter_trash

  -- Spam mark as read.
  local mailbox = gmail["[Gmail]/Spam"]
  local result = mailbox:is_unseen()
  mailbox:mark_seen(result)

  -- VTB messages filtering and mark as read.
  local mailbox = gmail.INBOX
  local result = mailbox:is_unseen() *
    mailbox:contain_field("X-Mailer", "Mailer by Oracle SENDMAIL") *
    mailbox:contain_from("CardMaster@vtb-sz.ru") *
    mailbox:contain_to("danila@kutkevich.com")
  mailbox:mark_seen(result)
  mailbox:move_messages(gmail.vtb, result)

  -- debian-user in Russian mailing list filtering
  -- <http://lists.debian.org/debian-russian>.
  -- local mailbox = gmail.INBOX
  -- local result = mailbox:is_unseen() *
  --                mailbox:contain_field("List-Id",
  --                                       "debian-russian.lists.debian.org")
  -- mailbox:move_messages(gmail.list_debian_russian, result)

  -- -- Django russian mailing list filtering.
  -- local mailbox = gmail.INBOX
  -- local result = mailbox:is_unseen() *
  --                mailbox:contain_field("List-Id",
  --                                       "django-russian.googlegroups.com")
  -- mailbox:move_messages(gmail.list_django_russian, result)

  -- Erlang в России mailing list filtering.
  -- <http://groups.google.com/group/erlang-russian>
  local mailbox = gmail.INBOX
  local result = mailbox:is_unseen() *
    mailbox:contain_field("List-Id",
                          "erlang-russian.googlegroups.com")
  mailbox:move_messages(gmail.list_erlang_russian, result)

  -- Russian Regional PostgreSQL List filtering. This list is for all
  -- Russian-speaking PostgreSQL community (KOI8R).
  -- ...

  -- <http://diamondcard.us> filtering.
  local mailbox = gmail.INBOX
  local result = mailbox:is_unseen() *
    mailbox:contain_from("support@diamondcard.us")
  mailbox:move_messages(gmail.lists, result)

  -- Instiki messages mailing list filtering.
  local mailbox = gmail.INBOX
  local result = mailbox:is_unseen() *
    mailbox:contain_field("List-Id",
                          "instiki-users.rubyforge.org")
  mailbox:move_messages(gmail.lists, result)

  -- FSF messages mailing list filtering.
  local mailbox = gmail.INBOX
  local result = mailbox:is_unseen() *
    (mailbox:contain_field("List-Id", "info-member.gnu.org") +
       mailbox:contain_from("info@defectivebydesign.org"))
  mailbox:move_messages(gmail.lists_fsf, result)

  -- Russian Gentoo user mailing list filtering.
  local mailbox = gmail.INBOX
  local result = mailbox:is_unseen() *
    mailbox:contain_field("List-Id",
                          "gentoo-user-ru.gentoo.org")
  mailbox:move_messages(gmail.community_gentoo, result)

  -- CIS Exim russian users mailing list filtering.
  local mailbox = gmail.INBOX
  local result = mailbox:is_unseen() *
    mailbox:contain_field("List-Id",
                          "exim-users.mailground.net")
  mailbox:move_messages(gmail.list_exim_users, result)

  -- -- SPb Haskell User Group mailing list filtering.
  -- local mailbox = gmail.INBOX
  -- local result = mailbox:is_unseen() *
  --                mailbox:contain_field("List-Id", "spbhug.googlegroups.com")
  -- mailbox:move_messages(gmail.lists, result)

  -- Emacs.

  -- Rails On Emacs mailing list filtering.
  local mailbox = gmail.INBOX
  local result = mailbox:is_unseen() *
    mailbox:contain_field("List-Id", "emacs-on-rails.googlegroups.com")
  mailbox:move_messages(gmail.community_emacs, result)

  -- Emacs planet feed.
  -- Non-english messages filtering.
  local mailbox = gmail.community_emacs
  local result = mailbox:is_unseen() *
    mailbox:contain_subject("Denis Evsjukov:")
  mailbox:move_messages(trash, result)

  -- Openmoko planet feed.

  -- Non-english messages filtering.
  local mailbox = gmail.feeds_openmoko
  local result = mailbox:is_unseen() *
    (mailbox:contain_subject("openmoko-fr:") +
       mailbox:contain_subject("Openmoko.cz") +
       mailbox:contain_subject("Xiangfu Liu:"))
  mailbox:move_messages(trash, result)

  -- Boring messages filtering.
  -- contain_subject("SlyBlog:") 1 fail
  -- contain_subject('Holger "zecke" Freyther:') 2 fails
  local mailbox = gmail.feeds_openmoko
  local result = mailbox:is_unseen() *
    (mailbox:contain_subject("Harald") + -- 5 fails
       mailbox:contain_subject("Sean Moss-Pultz:")) -- 4 fails
  mailbox:move_messages(trash, result)

  -- Linux Saint Petersburg users mailing list filtering.
  local mailbox = gmail.INBOX
  local result = mailbox:is_unseen() *
    mailbox:contain_field("List-Id", "spblinux.googlegroups.com")
  mailbox:move_messages(gmail.list_spblinux, result)

  -- Russian PostgreSQL Community mailing list filtering.
  local mailbox = gmail.INBOX
  local result = mailbox:is_unseen() *
    mailbox:contain_field("List-Id", "pgsql-ru-general.postgresql.org")
  mailbox:move_messages(gmail.lists, result)

  -- Feeds junk filtering.
  local mailbox = gmail.feeds
  local result = mailbox:is_unseen() *
    (mailbox:contain_body("Natural Beauties") +
       mailbox:contain_body("National Geographic Traveler") +
       mailbox:contain_body("Marie Claire"))
  mailbox:move_messages(trash, result)

  -- Firefox bugtracker messages filtering.
  local mailbox = gmail.INBOX
  local result = mailbox:is_unseen() *
    mailbox:contain_from("bugzilla-daemon@mozilla.org")
  mailbox:mark_seen(result)
  mailbox:move_messages(gmail.bugs, result)

  -- 42.molinos.ru messages filtering.
  local mailbox = gmail.INBOX
  local result = mailbox:is_unseen() *
    mailbox:contain_field("X-Redmine-Host", "42.molinos.ru") *
    mailbox:contain_from("admin@molinos.ru")
  mailbox:move_messages(gmail.molinos, result)

  -- Molinos bugs messages filtering.
  local mailbox = gmail.INBOX
  local result = mailbox:is_unseen() *
    mailbox:contain_from("errbit@500.molinos.ru")
  mailbox:move_messages(gmail.molinos, result)

  -- Molinos Juvelirtorg bugs messages filtering.
  local mailbox = gmail.INBOX
  local result = mailbox:is_unseen() *
    mailbox:contain_from("notifier@juvelirtorg.spb.ru") *
    mailbox:contain_subject("[Indicator Juvelirtorg]")
  mailbox:move_messages(gmail.molinos, result)

  -- Molinos Rolf bugs messages filtering.
  local mailbox = gmail.INBOX
  local result = mailbox:is_unseen() *
    mailbox:contain_from("notifier@guptek.ru") *
    mailbox:contain_subject("[Indicator Rolf]")
  mailbox:move_messages(gmail.molinos, result)

  -- Linode alert annoying messages filtering.
  local mailbox = gmail.INBOX
  local result = mailbox:is_unseen() *
    mailbox:contain_from("service@linode.com") *
    mailbox:contain_subject("Linode Alert - disk io rate - linode12286")
  mailbox:move_messages(trash, result)

  -- PROhq bugs messages filtering.
  local mailbox = gmail.INBOX
  local result = mailbox:is_unseen() *
    mailbox:contain_from("info@prohq.ru") *
    mailbox:contain_subject("[PROhq Production ERROR]")
  mailbox:move_messages(gmail.prohq, result)

  -- PROhq subscription messages filtering.
  local mailbox = gmail.INBOX
  local result = mailbox:is_unseen() *
    mailbox:contain_from("mailer@prohq.ru") *
    mailbox:contain_subject("[PROhq]")
  mailbox:move_messages(gmail.prohq, result)

  -- -- RIPN re-registration annoying messages filtering.
  -- local mailbox = gmail.INBOX
  -- local result = mailbox:is_unseen() *
  --                mailbox:contain_from("ru-ncc@ripn.net") *
  --                mailbox:contain_to("reg@da.pp.ru")
  -- mailbox:move_messages(trash, result)

  -- SKA forum annoying messages filtering.
  local mailbox = gmail.INBOX
  local result = mailbox:is_unseen() *
    mailbox:contain_from("admin@hc-ska.ru") *
    mailbox:contain_to("danil@kutkevich.org") *
    mailbox:contain_field("X-Mailer", "PhpBB3")
  --mailbox:contain_subject("Активируйте")
  mailbox:move_messages(trash, result)

  -- Thinking Sphinx mailing list filtering.
  local mailbox = gmail.INBOX
  local result = mailbox:is_unseen() *
    mailbox:contain_field("List-Id", "thinking-sphinx.googlegroups.com")
  mailbox:move_messages(gmail.lists, result)

  -- chaturbate.com messages filtering.
  local mailbox = gmail.INBOX
  local result = mailbox:is_unseen() *
    mailbox:contain_from("no-reply@chaturbate.com") *
    mailbox:contain_to("danil@kutkevich.org") *
    mailbox:contain_subject("Someone you follow is chaturbating")
  mailbox:move_messages(gmail.chaturbate, result)

  -- Delete drafts after sending from Gmail All Mail.
  -- local mailbox = gmail["All Mail"]
  -- local result = mailbox:is_unseen() *
  --                mailbox:contain_from("danil@kutkevich.org") *
  --                mailbox:contain_field("X-Mailer", "PhpBB3")
  -- mailbox:move_messages(trash, result)
end
