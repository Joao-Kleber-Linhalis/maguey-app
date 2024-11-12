#!/bin/bash

# Limpeza do Flutter
flutter clean
rm -rf pubspec.lock
# Remover Pods e arquivos relacionados
rm -rf ios/Pods
rm -rf ios/Podfile.lock
rm -rf ~/Library/Developer/Xcode/DerivedData
rm -rf ios/Flutter/Flutter.framework
rm -rf ios/Flutter/Flutter.podspec

# Atualizar pacotes Flutter
flutter packages upgrade

# Limpar Podfile.lock e reintegrar Pods
cd ios
rm -f Podfile.lock
pod deintegrate
pod update
pod install --repo-update
cd ..

echo "Limpeza e reinstalação concluídas!"
