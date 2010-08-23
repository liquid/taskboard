module UserSessionAwareActions

  EDITOR = User.new(:username => 'editor', :editor => true)
  VIEWER = User.new(:username => 'viewer', :editor => false)

  def get_as_editor(action, params = {})
    get_as_user action, params, EDITOR
  end

  def post_as_editor(action, params = {})
    post_as_user action, params, EDITOR
  end

  def get_as_viewer(action, params = {})
    get_as_user action, params, VIEWER
  end

  def post_as_viewer(action, params = {})
    post_as_user action, params, VIEWER
  end

  def get_as_user(action, params, user)
    get action, params, {:user_id => 1, :editor => user.editor, :user => user}
  end

  def post_as_user(action, params, user)
    post action, params, {:user_id => 1, :editor => user.editor, :user => user}
  end

end
