# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_190_624_125_250) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'addresses', force: :cascade do |t|
    t.string 'unrestricted_value', null: false
    t.string 'city', null: false
    t.string 'street', null: false
    t.string 'house', null: false
    t.string 'kladr_id', null: false
    t.string 'fias_id', null: false
    t.float 'lat', null: false
    t.float 'long', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'authentications', id: :serial, force: :cascade do |t|
    t.integer 'user_id', null: false
    t.string 'provider', limit: 255, null: false
    t.string 'uid', limit: 255, null: false
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.string 'link', limit: 255
    t.string 'token', limit: 255
    t.datetime 'token_expires'
  end

  create_table 'donations', force: :cascade do |t|
    t.float 'amount', null: false
    t.integer 'kind', null: false
    t.float 'amount_in_rub', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'event_participations', id: :serial, force: :cascade do |t|
    t.integer 'user_id'
    t.integer 'event_id'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.index ['event_id'], name: 'index_event_participations_on_event_id'
    t.index ['user_id'], name: 'index_event_participations_on_user_id'
  end

  create_table 'events', id: :serial, force: :cascade do |t|
    t.string 'title', limit: 255, null: false
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.integer 'organizer_id'
    t.boolean 'published', default: false
    t.text 'description'
    t.datetime 'started_at'
    t.string 'title_image', limit: 255
    t.string 'place', limit: 255
    t.datetime 'published_at'
    t.string 'slug', limit: 255
    t.point 'location'
    t.string 'foreign_link'
    t.integer 'pageviews', default: 0
    t.integer 'kind', default: 0
    t.bigint 'address_id'
    t.string 'address_comment'
    t.index ['address_id'], name: 'index_events_on_address_id'
    t.index ['organizer_id'], name: 'index_events_on_organizer_id'
    t.index ['slug'], name: 'index_events_on_slug', unique: true
  end

  create_table 'friendly_id_slugs', id: :serial, force: :cascade do |t|
    t.string 'slug', limit: 255, null: false
    t.integer 'sluggable_id', null: false
    t.string 'sluggable_type', limit: 50
    t.string 'scope', limit: 255
    t.datetime 'created_at'
    t.index %w[slug sluggable_type scope], name: 'index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope', unique: true
    t.index %w[slug sluggable_type], name: 'index_friendly_id_slugs_on_slug_and_sluggable_type'
    t.index ['sluggable_id'], name: 'index_friendly_id_slugs_on_sluggable_id'
    t.index ['sluggable_type'], name: 'index_friendly_id_slugs_on_sluggable_type'
  end

  create_table 'startups', force: :cascade do |t|
    t.string 'title', null: false
    t.string 'url'
    t.string 'slug'
    t.string 'logo'
    t.string 'intro'
    t.text 'description', null: false
    t.jsonb 'contacts', default: { 'name' => '', 'email' => '' }
    t.bigint 'author_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['author_id'], name: 'index_startups_on_author_id'
    t.index ['slug'], name: 'index_startups_on_slug'
    t.index ['title'], name: 'index_startups_on_title'
  end

  create_table 'taggings', id: :serial, force: :cascade do |t|
    t.integer 'tag_id'
    t.string 'taggable_type'
    t.integer 'taggable_id'
    t.string 'tagger_type'
    t.integer 'tagger_id'
    t.string 'context', limit: 128
    t.datetime 'created_at'
    t.index ['context'], name: 'index_taggings_on_context'
    t.index %w[tag_id taggable_id taggable_type context tagger_id tagger_type], name: 'taggings_idx', unique: true
    t.index ['tag_id'], name: 'index_taggings_on_tag_id'
    t.index %w[taggable_id taggable_type context], name: 'index_taggings_on_taggable_id_and_taggable_type_and_context'
    t.index %w[taggable_id taggable_type tagger_id context], name: 'taggings_idy'
    t.index ['taggable_id'], name: 'index_taggings_on_taggable_id'
    t.index ['taggable_type'], name: 'index_taggings_on_taggable_type'
    t.index %w[tagger_id tagger_type], name: 'index_taggings_on_tagger_id_and_tagger_type'
    t.index ['tagger_id'], name: 'index_taggings_on_tagger_id'
  end

  create_table 'tags', id: :serial, force: :cascade do |t|
    t.string 'name'
    t.integer 'taggings_count', default: 0
    t.index ['name'], name: 'index_tags_on_name', unique: true
  end

  create_table 'users', id: :serial, force: :cascade do |t|
    t.string 'email', limit: 255, default: '', null: false
    t.string 'encrypted_password', limit: 128, default: '', null: false
    t.string 'password_salt', limit: 255, default: '', null: false
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.string 'reset_password_token', limit: 255
    t.string 'nickname', limit: 255, default: ''
    t.integer 'role'
    t.string 'first_name', limit: 255
    t.string 'last_name', limit: 255
    t.text 'bio'
    t.string 'avatar_image', limit: 255
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.inet 'current_sign_in_ip'
    t.inet 'last_sign_in_ip'
    t.string 'confirmation_token', limit: 255
    t.datetime 'confirmed_at'
    t.datetime 'confirmation_sent_at'
    t.string 'unconfirmed_email', limit: 255
    t.string 'slug', limit: 255
    t.string 'website', limit: 255
    t.boolean 'subscription'
    t.string 'employment'
    t.index ['confirmation_token'], name: 'index_users_on_confirmation_token', unique: true
    t.index ['nickname'], name: 'index_users_on_nickname'
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token'
    t.index ['slug'], name: 'index_users_on_slug', unique: true
  end

  add_foreign_key 'events', 'addresses'
end
