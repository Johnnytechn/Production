---
title: include 文件
description: include 文件
services: azure-resource-manager
author: rockboyfor
manager: digimobile
ms.service: azure-resource-manager
ms.topic: include
origin.date: 02/20/2018
ms.date: 04/10/2018
ms.author: v-yeche
ms.custom: include file
ms.openlocfilehash: df52d275857bfeee8432cef6c0cc34b005c2f8ee
ms.sourcegitcommit: ffb8b1527965bb93e96f3e325facb1570312db82
ms.translationtype: HT
ms.contentlocale: zh-CN
ms.lasthandoff: 04/09/2018
---
若要为资源组添加两个标记，请使用 [az group update](https://docs.microsoft.com/cli/azure/group#az_group_update) 命令：

```azurecli
az group update -n myResourceGroup --set tags.Environment=Test tags.Dept=IT
```

让我们假设要添加第三个标记。 在包含新标记的情况下再次运行该命令。 它将追加到现有的标记后。

```azurecli
az group update -n myResourceGroup --set tags.Project=Documentation
```

资源不从资源组继承标记。 目前，资源组有三个标记，但资源没有任何标记。 若要将来自资源组的所有标记应用于其资源，并且保留资源上的现有标记，请使用以下脚本：

```azurecli
# Get the tags for the resource group
jsontag=$(az group show -n myResourceGroup --query tags)

# Reformat from JSON to space-delimited and equals sign
t=$(echo $jsontag | tr -d '"{},' | sed 's/: /=/g')

# Get the resource IDs for all resources in the resource group
r=$(az resource list -g myResourceGroup --query [].id --output tsv)

# Loop through each resource ID
for resid in $r
do
  # Get the tags for this resource
  jsonrtag=$(az resource show --id $resid --query tags)

  # Reformat from JSON to space-delimited and equals sign
  rt=$(echo $jsonrtag | tr -d '"{},' | sed 's/: /=/g')

  # Reapply the updated tags to this resource
  az resource tag --tags $t$rt --id $resid
done
```

或者，可以将来自资源组的标记应用于资源而不保留现有标记：

```azurecli
# Get the tags for the resource group
jsontag=$(az group show -n myResourceGroup --query tags)

# Reformat from JSON to space-delimited and equals sign
t=$(echo $jsontag | tr -d '"{},' | sed 's/: /=/g')

# Get the resource IDs for all resources in the resource group
r=$(az resource list -g myResourceGroup --query [].id --output tsv)

# Loop through each resource ID
for resid in $r
do
  # Apply tags from resource group to this resource
  az resource tag --tags $t --id $resid
done
```

若要将几个值组合到单个标记中，请使用 JSON 字符串。

```azurecli
az group update -n myResourceGroup --set tags.CostCenter='{"Dept":"IT","Environment":"Test"}'
```

若要删除资源组上的所有标记，请使用：

```azurecli
az group update -n myResourceGroup --remove tags
```
<!--ms.date: 04/10/2018-->