
  User.__elasticsearch__.create_index! force: true
  User.import
  Post.__elasticsearch__.create_index! force: true
  Post.import
