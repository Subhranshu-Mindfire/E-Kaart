class UserDatatable < AjaxDatatablesRails::ActiveRecord
  # delegate :link_to, :edit_user_path, :user_path, to: :@view, allow_nil: true

  self.nulls_last = true

  def view_columns
    @view_columns ||= {
      id:         { source: "User.id" },
      first_name: { source: "User.first_name", cond: :like, searchable: true, orderable: true },
      last_name:  { source: "User.last_name",  cond: :like, nulls_last: true },
      email:      { source: "User.email" },
      roles:      { source: "Role.title"},
      status:     { source: "User.status"},
    }
  end

  def data
    records.map do |record|
      {
        id:         record.id,
        first_name: record.first_name,
        last_name:  record.last_name,
        email:      record.email,
        roles:      record.roles.map{ |role| role.title }.join(","),
        status:     record.status,
        # actions: [ link_to("Edit", edit_user_path(record)),
        # link_to("Delete", user_path(record), data: { turbo_method: :delete, confirm: 'Are you sure?' }) ]
        
      }
    end
  end

  def get_raw_records
    User.joins(:roles)
  end

end
