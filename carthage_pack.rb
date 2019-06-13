#使用0.33版本的carthage
puts `carthage build --no-skip-current --verbose --platform iOS --configuration release --project-directory ${PODS_ROOT}`