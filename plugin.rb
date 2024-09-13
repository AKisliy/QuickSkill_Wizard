# frozen_string_literal: true

# name: quickskill-custom-wizard
# about: Plugin to customize wizard for quickskill purposes
# meta_topic_id: TODO
# version: 0.0.1
# authors: AKisliy
# url: TODO
# required_version: 2.7.0

register_asset "stylesheets/common/course.scss"

enabled_site_setting :plugin_name_enabled

module ::QuickskillCustomWizardModule
  PLUGIN_NAME = "quickskill-custom-wizard"
end

require_relative "lib/my_plugin_module/engine"

after_initialize do
  on(:build_wizard) do |wizard|
    wizard.append_step('courselogo', after: "privacy") do |step|
      step.emoji = "framed_picture"
      step.add_field(id: 'course_logo', type: 'image', value: SiteSetting.course_logo)

      step.on_update do |updater|
        if SiteSetting.course_logo != updater.fields[:course_logo]
          updater.apply_settings(:course_logo)
          updater.refresh_required = true
        end
      end
    end
  end
end
