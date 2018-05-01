-- -*- coding: utf-8-unix; -*-
function filtering_danil_at_kutkevich_org()
  -- luadns.com messages filtering
  local mailbox = danil_at_kutkevich_org.INBOX
  local result = mailbox:is_unseen() *
    mailbox:contain_from("contact@luadns.com")
  mailbox:move_messages(danil_at_kutkevich_org.luadns, result)

  -- noreply@youtube.com messages filtering
  local mailbox = danil_at_kutkevich_org.INBOX
  local result = mailbox:is_unseen() *
    mailbox:contain_from("noreply@youtube.com")
  mailbox:move_messages(danil_at_kutkevich_org.youtube_feeds, result)

  -- notifications@disqus.net messages filtering
  local mailbox = danil_at_kutkevich_org.INBOX
  local result = mailbox:is_unseen() *
    mailbox:contain_from("notifications@disqus.net")
  mailbox:move_messages(danil_at_kutkevich_org.disqus_feeds, result)

  -- ror2ru mailing list filtering
  -- https://groups.google.com/forum/#!forum/ror2ru
  local mailbox = danil_at_kutkevich_org.INBOX
  local result = mailbox:is_unseen() *
    mailbox:contain_field("List-Id", "ror2ru.googlegroups.com")
  mailbox:move_messages(danil_at_kutkevich_org.list_ror2ru, result)

  -- Arch Linux Saint Petersburg users group messages filtering
  -- <http://groups.google.com/group/spb-archlinux>.
  local mailbox = danil_at_kutkevich_org.INBOX
  local result = mailbox:is_unseen() *
    mailbox:contain_field("List-Id", "spb-archlinux.googlegroups.com") *
    mailbox:contain_field("list-post", "<spb-archlinux.googlegroups.com>")
  mailbox:move_messages(danil_at_kutkevich_org.lists, result)

  -- Arch Linux Saint Petersburg users group messages filtering
  -- <http://groups.google.com/group/spb-archlinux>.
  local mailbox = danil_at_kutkevich_org.INBOX
  local result = mailbox:is_unseen() *
    mailbox:contain_field("List-Id", "spb-archlinux.googlegroups.com") *
    mailbox:contain_field("list-post", "<spb-archlinux.googlegroups.com>")
  mailbox:move_messages(danil_at_kutkevich_org.lists, result)

  -- Bazaar russion users group list messages filtering
  -- <http://groups.google.com/group/ru_bz>
  local mailbox = danil_at_kutkevich_org.INBOX
  local result = mailbox:is_unseen() *
    mailbox:contain_field("List-Id", "ru_bzr.googlegroups.com") *
    mailbox:contain_field("list-post", "<ru_bzr.googlegroups.com>")
  mailbox:move_messages(danil_at_kutkevich_org.lists, result)

  -- healthintersections.com.au messages filtering
  local mailbox = danil_at_kutkevich_org.INBOX
  local result = mailbox:is_unseen() *
    mailbox:contain_field("List-Subscribe", "http://www.healthintersections.com.au")
  mailbox:move_messages(danil_at_kutkevich_org.fhir_planet, result)

  -- hl7 and holiadvice notifications messages filtering
  local mailbox = danil_at_kutkevich_org.INBOX
  local result = mailbox:is_unseen() *
    mailbox:contain_from("notifier@mail.rollbar.com") *
    (mailbox:contain_subject("holiadvice") +
       mailbox:contain_subject("[hl7rus]"))
  mailbox:move_messages(danil_at_kutkevich_org.waveaccess, result)

  -- drone.io success notifications messages filtering
  local mailbox = danil_at_kutkevich_org.INBOX
  local result = mailbox:is_unseen() *
    mailbox:contain_from("builds@drone.io") *
    mailbox:contain_subject("[SUCCESS]")
  mailbox:move_messages(danil_at_kutkevich_org.sieve_trash, result)

  -- drone.io success notifications messages filtering
  local mailbox = danil_at_kutkevich_org.INBOX
  local result = mailbox:is_unseen() *
    mailbox:contain_from("builds@drone.io") *
    mailbox:contain_subject("[SUCCESS]")
  mailbox:move_messages(danil_at_kutkevich_org.sieve_trash, result)

  -- armor5games cyrillic messages filtering
  local mailbox = danil_at_kutkevich_org.INBOX
  local result = mailbox:is_unseen() *
    messages_to_armor5games(mailbox) -
    messages_from_armor5games_hosts(mailbox) -
    mailbox:contain_from("notifications@bugsnag.com") *
    (mailbox:match_subject("[а-яА-Я]") +
       mailbox:match_body("[а-яА-Я]"))
  mailbox:move_messages(danil_at_kutkevich_org.sieve_trash, result)

  -- armor5games/bugsnag annoying messages filtering
  local mailbox = danil_at_kutkevich_org.INBOX
  local result = mailbox:is_unseen() *
    messages_to_armor5games(mailbox) *
    mailbox:contain_from("support@bugsnag.com") *
    mailbox:contain_subject("Some events are being dropped due to sampling")
  mailbox:move_messages(danil_at_kutkevich_org.sieve_trash, result)

end

function messages_to_armor5games(mailbox)
  return ((mailbox:contain_to("armor5games@gmail.com") +
             mailbox:contain_cc("armor5games@gmail.com") +
             mailbox:contain_bcc("armor5games@gmail.com")) +
      (mailbox:contain_to("admin@armor5games.com") +
         mailbox:contain_cc("admin@armor5games.com") +
         mailbox:contain_bcc("admin@armor5games.com")))
end

function messages_from_armor5games_hosts(mailbox)
  return (mailbox:contain_from("ah3.armor5games.com") +
            mailbox:contain_from("ah5.armor5games.com") +
            mailbox:contain_from("ah7.armor5games.com") +
            mailbox:contain_from("ah9.armor5games.com") +
            mailbox:contain_from("ah10.armor5games.com") +
            mailbox:contain_from("bh1.armor5games.com"))
end
