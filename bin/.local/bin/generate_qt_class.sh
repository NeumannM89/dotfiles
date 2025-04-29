#!/bin/bash

# Check if a class name was provided
if [ -z "$1" ]; then
    echo "Usage: $0 ClassName"
    exit 1
fi

CLASS_NAME=$1
HEADER_FILE="${CLASS_NAME}.h"
SOURCE_FILE="${CLASS_NAME}.cpp"
INCLUDE_GUARD=$(echo "${CLASS_NAME}_H" | tr '[:lower:]' '[:upper:]')

# Create the header file
cat << EOF > "$HEADER_FILE"
#ifndef ${INCLUDE_GUARD}
#define ${INCLUDE_GUARD}

#include <QObject>

class ${CLASS_NAME} : public QObject
{
    Q_OBJECT

public:
    explicit ${CLASS_NAME}(QObject *parent = nullptr);
    ~${CLASS_NAME}();

signals:

public slots:
};

#endif // ${INCLUDE_GUARD}
EOF

# Create the source file
cat << EOF > "$SOURCE_FILE"
#include "${CLASS_NAME}.h"

${CLASS_NAME}::${CLASS_NAME}(QObject *parent)
    : QObject(parent)
{
}

${CLASS_NAME}::~${CLASS_NAME}()
{
}
EOF

echo "Generated ${HEADER_FILE} and ${SOURCE_FILE}."
