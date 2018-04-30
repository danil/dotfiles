-- -*- coding: utf-8-unix; -*-
function danil_at_kutkevich_org_filtering()
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

  -- } elsif header :is ["list-id", "list-post"] ["ru_bzr.googlegroups.com", "<ru_bzr.googlegroups.com>"] {
  --   fileinto "INBOX.lists";


end
