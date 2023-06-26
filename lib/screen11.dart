import 'package:flutter/material.dart';
import 'package:basic/detail_screen.dart';
import 'package:basic/provider.dart';
import 'package:provider/provider.dart';

class Screen12 extends StatefulWidget {
  const Screen12({super.key});

  @override
  State<Screen12> createState() => _Screen12State();
}

class _Screen12State extends State<Screen12> {
  bool clear = false;

  @override
  void initState() {
    Future.microtask(() {
      Provider.of<Provider12>(context, listen: false).initialData();
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pertemuan11'),
        actions: [showMenuList(context)],
      ),
      body: clear ? const Text('Data Tidak ditemukan') : showBody(context),
    );
  }

  showBody(BuildContext context) {
    final prov = Provider.of<Provider12>(context);
    if (prov.data == null) {
      return const CircularProgressIndicator();
    } else {
      return Row(
        children: List.generate(prov.data['data']!.length, (index) {
          var item = prov.data['data']![index];
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailScreen(model: item)));
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: 200,
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          item['img'],
                        ),
                      ),
                      title: Text(
                        item['model'],
                      ),
                      subtitle: Text(item['developer']),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.00),
                      child: Text(
                        item['desc'].toString().length >= 100
                            ? item['desc'].toString().substring(0, 100) +
                                ".... read more"
                            : item['desc'],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonBar(
                          alignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Rp. ${item['price'].toString()},-',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('Rating ${item['rating'].toString()}'),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.thumb_up)),
                            IconButton(
                                onPressed: () {}, icon: const Icon(Icons.share))
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      );
    }
  }

  showMenuList(BuildContext context) {
    final prov = Provider.of<Provider12>(context);

    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry>[
          PopupMenuItem(
            child: ListTile(
              onTap: (() {
                prov.ubahList('hp');
                clear = false;
              }),
              leading: const Icon(Icons.phone),
              title: const Text('Hp'),
            ),
          ),
          const PopupMenuDivider(),
          PopupMenuItem(
            child: ListTile(
              onTap: () {
                prov.ubahList('laptop');
                clear = false;
              },
              leading: const Icon(Icons.laptop),
              title: const Text('Laptop'),
            ),
          ),
          PopupMenuItem(
              child: ListTile(
            onTap: () {
              setState(() {
                clear = true;
              });
            },
            leading: const Icon(Icons.clear),
            title: const Text('Clear'),
          ))
        ];
      },
    );
  }
}
