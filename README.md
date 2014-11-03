KUITableViewController
======================
[![Gitter](https://badges.gitter.im/Join Chat.svg)](https://gitter.im/jakarmy/KUITableViewController?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

KUITableViewController is an encapsulation of the UITableViewController class that lets you use the same class every time you need a TableView, not needing to set up a new one every time.

The KUITableViewController class is intended to have one xib file where you add all the prototype cells you'll use along the project.

You have to pass on the information data or structure you want the table view to adopt.
Here's an example of the structure in JSON notation. In the project, you have to use [NSMutableDictionary](https://developer.apple.com/library/mac/#documentation/Cocoa/Reference/Foundation/Classes/NSMutableDictionary_Class/Reference/Reference.html) and [NSMutableArray](https://developer.apple.com/library/mac/#documentation/Cocoa/Reference/Foundation/Classes/NSMutableArray_Class/Reference/Reference.html) to pass on the data

```
[
  {
		"section_header_title" : "Friends",
		"section_footer_title" : "You have 48 friends",
		"section_header_view" : "<UIView>",
		"section_footer_view" : "<UIView>",
		"section_data" : 
							[
								{
									"cell_identifier" : "FriendsCell",
									"cell_text" : "<NSString>",
									"cell_text_font_size" : "14",
									"cell_attributed_text" : "<NSAttributedString>",
									"cell_detail_text" : "<NSString>",
									"cell_detail_text_font_size" : "14",
									"cell_detail_attributed_text" : "<NSAttributedString>",
									"cell_image_name" : "thumbnail_placeholder.png",
									"cell_image_url" : "http://mydomain.com/assets/image.png"
								},
								{...}
							]
	},
	{...}
]
```

Contact
======================

Brought to you by
[Juan Antonio Karmy](http://jakarmy.com)
[@jkarmy](https://twitter.com/jkarmy)
